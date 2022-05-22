Rails.application.routes.draw do

 #place
  namespace :places do
    # get 'place/list' request
    get 'home'
    get '/',                        to: 'places#index'
  end
  post 'place/:id' => 'places#create'
  resources :places, :only => [ :index, :create, :destroy ]
  # 記事詳細表示のルーティングにネスト
  resources :places, expect: [:index] do
    resource :favorites, only: [:create, :destroy]
  end

#user
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  # マイページのルーティングにネスト
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
  #トップページをログイン画面に
  devise_scope :user do
    root "users/sessions#new"
  end
  get '/users/sign_out' => 'devise/sessions#destroy'
  get 'users/show'

#my_places
  get "my_places/todo"
  post 'my_places/todo' => 'my_places#create'
  get "my_places/favorites"
  get "my_places/completes"
  resources :my_places, :only => [ :create, :destroy, :edit, :update ]

#favorites
  post 'favorites/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorites/:id' => 'favorites#destroy', as: 'destroy_favorite'

#completes
  post 'completes/:id' => 'completes#create', as: 'create_complete'

#all_palces
  get "all_places/all"
  resources :places, :only => [ :all]

end
