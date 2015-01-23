Rails.application.routes.draw do

  get 'sessions/login'

  get 'sessions/logout'

  resources :posts do
    member do
      get 'vote'
    end
  end

#  GET	/photos	photos#index	display a list of all photos
  # get 'posts' => 'posts#index'
#GET	/photos/new	photos#new	return an HTML form for creating a new photo
  # get 'posts/new' => 'posts#new', as: :new_post
#  POST	/photos	photos#create	create a new photo
  # post 'posts' => 'posts#create'
#GET	/photos/:id	photos#show	display a specific photo
  # get 'posts/:id' => 'posts#show'
#  GET	/photos/:id/edit	photos#edit	return an HTML form for editing a photo
  # get 'posts/:id/edit' => 'posts#edit'
#  PATCH/PUT	/photos/:id	photos#update	update a specific photo
  # put 'posts/:id' => 'posts#update'
#  DELETE	/photos/:id	photos#destroy	delete a specific photo
  # delete 'posts/:id' => 'posts#destroy'

  #  resources :posts, only: [:vote]

  post 'sessions' => 'sessions#create'

  get 'registration' => 'users#new'#, as: 'registration'

  post 'users' => 'users#create'

  get 'pages/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

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
