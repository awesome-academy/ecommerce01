
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root 'pages#home'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # About Shopping cart
  get 'carts/:id' => 'carts#show', as: 'cart'
  delete 'carts/:id' => 'carts#destroy'

  post 'order_items/:id/add' => 'order_items#add_quantity', as: 'order_item_add'
  post 'order_items/:id/reduce' => 'order_items#reduce_quantity', as: 'order_reduce'
  post 'order_items' => 'order_items#create'
  get 'order_items/:id' => 'order_items#show', as: 'order_item'
  delete 'order_items/:id' => 'order_items#destroy'

  get 'orders/show'

  resources :users
  resources :products
  resources :orders
  resources :stores
end
