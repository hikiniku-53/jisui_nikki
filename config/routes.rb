Rails.application.routes.draw do

  # root_path
  root to: 'public/homes#top'


  # devise関連
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  #ゲストログイン用のルーティング
  devise_scope :customer do
    post '/guest_sign_in', to: 'public/sessions#new_guest'
  end


  #public_action
  scope module: :public do

    # homes_action
    get '/about' => 'homes#about', as: 'about'


    # customers_action
    get '/customers' => 'customers#show', as: 'customer'
    get '/customers/edit' => 'customers#edit'
    patch '/customers' => 'customers#update'


    # foods_action
    resources :foods, only: [:index, :genre_search, :new, :create, :show, :edit, :update] do
      resources :comments, only: [:create]
      resource :prices, only: [:create, :update]
    end
    get '/foods/genre/:genre_id' => 'foods#genre', as: 'foods_genre'
    # get 'foods/search' => 'foods#search'

    # cutting_board_foods_action
    resources :cutting_board_foods
    delete '/cutting_board_foods' => 'cutting_board_foods#destroy_all', as: 'cutting_board_foods_destroy_all'


    # recipes_action
    resources :recipes, only: [:new, :index, :show, :create] do
      resource :favorites, only: [:create, :destroy]
    end
    post '/recipes/confirmation' => 'recipes#confirmation'
    get 'recipe/search_tag' => 'recipes#search_tag'
    get '/recipe/search_favorite' => 'recipes#search_favorite'

    # meal_action
    resources :meals, only: [:show, :create, :update, :destroy]

    # diary_action
    resources :diaries, only: [:index, :show, :create, :update, :destroy]


  end


  # admin_action
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  ##admin_action
  namespace :admin do

    # foods
    resources :foods, only: [:index, :show, :edit, :update, :destroy]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
