class DashboardController < ApplicationController
before_action :authenticate_user!

  def invoices
  	 @charges = Charge.where(user_id: current_user).all
  end

  def billing
  end

  def your_questions
    @questions = Question.where(user_id: current_user).all
  end

end
