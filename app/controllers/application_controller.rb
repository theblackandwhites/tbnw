class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  @alladmins = User.where(admin: true).all
  @allusers = User.all
  @mymembers = @allusers.count - @alladmins.count

  @latest_post = Calender.last

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :address, :postcode, :company_name, :stripe_id, :stripe_subscription_id, :credit_card_last_4, :credit_card_exp_month, :credit_card_exp_year, :credit_card_type, :suspended, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :address, :postcode, :company_name, :stripe_id, :stripe_subscription_id, :credit_card_last_4, :credit_card_exp_month, :credit_card_exp_year, :credit_card_type, :suspended, :avatar])
  end
end
