Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
  	namespace :v1 do
  	  namespace :user do
        # resources :items, except: [:new, :edit]
        # resources :users, only: [:create, :show, :update]
        resources :users, only: [:index, :update]
        resources :projects, only: [:index, :show]
        resources :tasks, only: [:index, :show, :create, :update]
        resources :daily_tasks, only: [:index, :show, :create, :update, :destory]
      end
      namespace :admin do
        resources :projects, only: [:index, :show]
        resources :tasks, only: [:index, :show]
      end
    end
  end
  
end
