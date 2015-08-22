Rails.application.routes.draw do 
 
  devise_for :admins
  devise_for :users, :controllers => {:users_controller => "users_controller"}
   
  root :to => 'contents#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  get 'users/:id/activedonations' => 'users#active_donations', :as => :active_donations_users
  get 'users/:id' => 'users#show', :as => :show_users
  get 'requests/:id/donate' => 'requests#donate', :as => :donate_requests
  get 'requests/:id/donors' => 'requests#donors', :as => :donors_requests
  get 'requests/:id/cancel_donate' => 'requests#cancel_donate', :as => :cancel_donate_requests
  
  resources :users, :only => [:show, :active_donations] do
    member do 
      get :pause
      get :unpause 
    end
  end

  resources :requests do
    collection do
      get 'relatedrequests'  
    end
  end 


  resources :contents, only: [:index] do
    collection do
      get :about
      get :donor_info
      get :donation_info
      get :blood_info
      get :patient_info
      get :news
      get :contact
    end
  end

  resources :controls, only: [:index] do
    collection do
      get :new
      get :dashboard
      get :admins
      post :create_new_admin
      post :update
      post :delete
    end
  end
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
