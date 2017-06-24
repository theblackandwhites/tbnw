Rails.application.routes.draw do

  #Devise resources
  devise_for :users, controllers: { registrations: "registrations" }

  resources :reply_answers
  resources :replies
  resources :comments
  resources :hacks
  resources :answers
  resources :questions
  resources :categories
  resources :messages
  resources :workshops
  resources :charges
  scope "/admin" do
    resources :users
  end

  #Dashboard Pages
  get 'dashboard/invoices'
  get 'dashboard/billing'
  get 'dashboard/your_questions'

  #Static Pages
  get 'static/home'
  get 'static/community_support'
  get 'static/hack_videos'
  get 'tools_and_resources' => 'static#tools_and_resources'
  get 'static/wingman_workshops'

  #Charges
  get 'new_subscriber' => 'charges#new_subscriber'
  post 'create_subscription' => 'charges#create_subscription'
  post 'remove_me' => 'charges#remove_me'
  post 'update_billing' => 'charges#update_billing'

  #Stripe Webhooks Path
  mount StripeEvent::Engine, at: '/stripe/webhooks' # provide a custom path

  #Attachinary
  mount Attachinary::Engine => "/attachinary"
  
  #Root
  root to: "static#home"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
