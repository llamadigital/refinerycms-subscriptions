Refinery::Application.routes.draw do

  # public facing new subscription page
  # helper is new_subscription_url etc
  get '/subscribe', :to => 'subscriptions#new', :as => 'new_subscription'

  # all other public facing urls start /subscribe
  # the only true rest action is create
  # the rails helpers use subscriptions eg
  # the controller is subscriptions
  resources :subscribe, :only => :create, :as => :subscriptions, :controller => 'subscriptions' do
    collection do
      get :thank_you
      get :activate
      get :activated
      get :not_activated
    end
  end

  # admin routes
  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :subscriptions, :only => [:index, :show, :destroy] do
      #collection do
        #get :spam
      #end
      #member do
        #get :toggle_spam
      #end
    end
    resources :subscription_settings, :only => [:edit, :update]
  end
end

