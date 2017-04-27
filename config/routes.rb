Rails.application.routes.draw do
  
  get '/' => 'home#index'
  get '/profile' => 'home#profile'
  get '/profile/create' => 'home#create'
  post '/profile/create/confirm' => 'home#create_profile'
  get '/profile/edit' => 'home#edit'
  post '/profile/edit/confirm' => 'home#edit_profile'

  get '/groups' => 'group#index'
  get '/groups/create' => 'group#create'
  post '/groups/create/confirm' => 'group#create_group'
  get '/groups/show/:group_id' => 'group#show'

  # post '/groups/participant/add' => 'group#add_participant'
  post '/groups/participant/add/remote' => 'group#add_participant_remote'
  
  post '/groups/participant/remove' => 'group#remove_participant'  
  post '/groups/participant/make_admin' => 'group#make_admin_participant'

  post '/transactions' => 'transaction#evaluate'

  get '/chat' => 'chat#index'
  post '/messages/new' => 'chat#new_message'

  post '/abc' => 'chat#append_message'
  devise_for :users

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
