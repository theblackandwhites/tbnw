class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new_subscriber

  end

  def show
    @charge = Charge.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new

        pdf.font("Helvetica") do
          pdf.text "THE BLACK & WHITES", :align => :left, :size => 20, :style => :bold; 
        end
       
        pdf.font("Helvetica") do
            pdf.text "Forget everything you think you know about marketing", :align => :left, :size => 7, :color => '000000',:kerning => true, :character_spacing => 1; 
        end

        pdf.rectangle [0, 610], 225, 40
        pdf.fill_color "000000"
        pdf.fill

        pdf.bounding_box([10, 600], :width => 250, :height => 50) do

          pdf.font("Helvetica") do
              pdf.text "YOUR INVOICE", :align => :left, :size => 30, :color => 'ffffff',:kerning => true, :character_spacing => -1, :style => :bold; 
          end

          
        end



        pdf.bounding_box([280, 600], :width => 250, :height => 50) do

          pdf.font("Helvetica") do
              pdf.text "INVOICE# 0413#{@charge.id}", :align => :right, :size => 10, :color => '000000',:kerning => true, :character_spacing => 0, :style => :bold;
              pdf.text "ABN#: 32594080753 ", :align => :right, :size => 10, :color => '000000',:kerning => true, :character_spacing => 0, :style => :bold;
              pdf.move_down 5
              pdf.text "#{@charge.created_at.strftime("%d %b %Y")} ", :align => :right, :size => 10, :color => '000000',:kerning => true, :character_spacing => 0;           
              
          end
        end

        pdf.bounding_box([0, 500], :width => 530, :height => 350) do
          
          
            pdf.stroke_color "e5e5e5"

            pdf.move_down 20
            
            pdf.text "The Black & Whites Monthly Subscription", :color => '000000'
            pdf.text "#{view_context.number_to_currency(@charge.amount / 100, precision: 0)}", :color => '000000', :align => :right
            pdf.move_down 20
            pdf.stroke_horizontal_rule

        

        end       

        pdf.bounding_box([300, 250], :width =>230, :height => 100) do
          pdf.text "Sub Total:  #{view_context.number_to_currency(@charge.amount / 100, precision: 2)}", :align => :right, :size => 12, :color => 'cccccc'
        end

        pdf.bounding_box([300, 180], :width =>230, :height => 100) do
          pdf.text "Total:  #{view_context.number_to_currency(@charge.amount / 100, precision: 2)}", :align => :right, :size => 20, :color => '000000'
        end

        pdf.bounding_box([0, 100], :width =>530, :height => 100) do
          pdf.text "On behalf of B&W Syndicate, thank you for using our services. We hope you have received the necessary skills to go forth and conquer. We value ourselves on your success and satisfaction so please let us know if you did not find our services helpful.", :align => :center, :size => 8, :color => '000000'

        end

        pdf.bounding_box([0, 50], :width =>530, :height => 100) do
          pdf.text "B&W Syndicate", :align => :center, :size => 10, :color => '000000', :style => :bold;

        end


        send_data pdf.render, filename: "invoice_#0413#{@charge.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"

      end
    end
  end

  def create_subscription

    Stripe.api_key = ENV["stripe_seceret_key"]
    @user = current_user

    #Get creditcard params
    token = params[:stripeToken]

    #Create customer
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source => token,
    )

    #Assign customer to a subscription plan
    subscription = Stripe::Subscription.create(
    :customer => customer.id,
    :plan => "basic",
    )

    #Charge customer $1
    charge = Stripe::Charge.create(
      :amount => 100,
      :currency => "aud",
      :customer => customer.id,
    )

    #Add stripe_id, subscription_id to user
    @user.update_attributes(:stripe_id => customer.id, :stripe_subscription_id => subscription.id)
    @user.save

    #Redirect to finish set up
    redirect_to edit_user_registration_path

  end

  def remove_me



    Stripe.api_key = ENV["stripe_seceret_key"]
    @user = current_user

    @useremail = Digest::MD5.hexdigest(@user.email)

    if @user.stripe_subscription_id.blank?
      @user.destroy
    else
      subscription = Stripe::Subscription.retrieve(@user.stripe_subscription_id)
      subscription.delete
      @user.destroy
    end

    gibbon = Gibbon::Request.new(api_key: "0a9ffb6db9a6a723e4f0841f18dc3636-us15")
    gibbon.timeout = 30
    gibbon.open_timeout = 30
    gibbon.lists("4c140da556").members(@useremail).update(body: { status: "unsubscribed" })

    redirect_to root_path

  end

  def update_billing

    @user = current_user
    Stripe.api_key = ENV["stripe_seceret_key"]
    #find credit card details
    token = params[:stripeToken]

    #find customer in stripe
    update_billing = Stripe::Customer.retrieve(@user.stripe_id)
    #update stripe details
    update_billing.email = params[:stripeEmail]
    update_billing.source = token
    update_billing.save

    #update user details in our database
    #Add stripe_id, subscription_id to user
    card = update_billing.sources.first

    @user.update_attributes(
      suspended: false, 
      credit_card_type: card.brand, 
      credit_card_exp_month: card.exp_month, 
      credit_card_exp_year: card.exp_year, 
      credit_card_last_4: card.last4
      )

    @user.save

  redirect_to dashboard_billing_path
  end

  
end
