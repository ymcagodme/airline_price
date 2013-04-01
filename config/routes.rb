AirlinePrice::Application.routes.draw do
  devise_for :users

  authenticated :user do
    root :to => 'high_voltage/pages#show', :id => 'welcome'
  end

  root :to => 'high_voltage/pages#show', :id => 'welcome'

  resources :subscriptions

end
