class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :messages, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :replies, dependent: :destroy
	has_many :answers, dependent: :destroy
	has_many :charges, dependent: :destroy
	has_many :questions, dependent: :destroy

	has_attachment  :avatar, accept: [:jpg, :png, :gif]

	after_create :subscribe_user_to_mailing_list
 
  	private
 
  	def subscribe_user_to_mailing_list
    	SubscribeUserToMailingListJob.perform_later(self)
  	end


end
