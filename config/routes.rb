Rails.application.routes.draw do
  # root
  root :to => 'places#home'
  # place
  namespace :places do
    # get 'place/list' request
    get 'home'
    post 'home'
  end
  get 'places', to: 'places#home'
  resources :places, :only => [:home, :create, :destroy]
  # 記事詳細表示のルーティングにネスト

  # user
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }


  # マイページのルーティングにネスト
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
  # トップページをログイン画面に
  devise_scope :user do
    root "users/sessions#new"
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  # my_places
  get "my_places/todo"
  post 'my_places/todo' => 'my_places#create'
  get "my_places/favorites"
  get "my_places/completes"
  resources :my_places, :only => [:create, :destroy, :edit, :update]

  # favorites
  post 'favorites/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorites/:id' => 'favorites#destroy', as: 'destroy_favorite'

  # completes
  post 'completes/:id' => 'completes#create', as: 'create_complete'

  # all_palces
  get "all_places/all"
  resources :places, :only => [:all]
end
