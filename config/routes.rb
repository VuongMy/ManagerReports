ManagerReports::Application.routes.draw do
  get "users/new"
  # get "users/group_list"
  resources :sessions, only: [:new, :create, :destroy]
  #get "daily_reports/home"
  #get "daily_reports/help"
  #get "daily_reports/about"
  #get "daily_reports/contact"
  resources :activations, only: [:update]
  resources :users
  resources :groups
  resources :catalogs
  resources :reports
  root  'daily_reports#home'
  match '/activations', to: "activations#update", via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/help',    to: 'daily_reports#help',    via: 'get'
  match '/about',    to: 'daily_reports#about',    via: 'get'
  match '/contact',    to: 'daily_reports#contact',    via: 'get'
  match '/home', to:'users#show', via:'get'
  get 'file_upload', to: 'reports#file_upload'
  get 'get_name', to: 'reports#get_name'
  match '/group_list', to: 'users#group_list', via: 'get'
  match '/report_member', to: 'reports#report_member', via: 'get'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
