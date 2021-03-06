class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  require 'digest/md5'

  def index
   @users = User.where.not(id: current_user.id).all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @useremail = Digest::MD5.hexdigest(@user.email)

    Stripe.api_key = ENV["stripe_seceret_key"]

    if @user.stripe_subscription_id.blank?
      @user.destroy
    else
      subscription = Stripe::Subscription.retrieve(@user.stripe_subscription_id)
      subscription.delete
      @user.destroy
    end

    gibbon = Gibbon::Request.new(api_key: ENV["mailchimp_api_key"])
    gibbon.timeout = 30
    gibbon.open_timeout = 30
    gibbon.lists("4c140da556").members(@useremail).update(body: { status: "unsubscribed" })



    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :address, :postcode, :company_name, :stripe_id, :stripe_subscription_id, :credit_card_last_4, :credit_card_exp_month, :credit_card_exp_year, :credit_card_type, :suspended, :avatar)
    end
end
