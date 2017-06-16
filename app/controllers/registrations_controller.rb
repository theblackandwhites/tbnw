class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    @user = current_user
    @user.update_attributes(:suspended => true)
    @user.save
    '/new_subscriber'

  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end