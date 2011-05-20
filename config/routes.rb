Refinery::Application.routes.draw do
  get '/subscribe', :to => 'subscriptions#new', :as => 'new_subscription'

  resources :subscribe, :only => :create, :as => :subscriptions, :controller => 'subscriptions' do
    collection do
      get :thank_you
      get :activate
      get :activated
      get :not_activated
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :subscriptions, :only => [:index, :show, :destroy] do
      collection do
        get :spam
      end
      member do
        get :toggle_spam
      end
    end
    resources :subscription_settings, :only => [:edit, :update]
  end
end

