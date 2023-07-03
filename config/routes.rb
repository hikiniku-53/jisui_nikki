Rails.application.routes.draw do

  namespace :public do
    get 'customer/show'
    get 'customer/edit'
    get 'customer/update'
  end
  namespace :public do

  end
  root to: 'public/homes#top'

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  ##public_action
  scope module: :public do

    get '/about' => 'homes#about', as: 'about'

    get '/customers' => 'customers#show', as: 'customer'
    get '/customers/edit' => 'customers#edit'
    patch '/customers' => 'customers#update'

    resources :foods, only: [:index, :genre_search, :new, :create, :show, :edit, :update] do
      resources :comments, only: [:create]
    end

    # get 'comments/create'
    
    resources :cutting_board_foods
    delete '/cutting_board_foods' => 'cutting_board_foods#destroy_all', as: 'cutting_board_foods_destroy_all'

    resources :recipes, only: [:new, :index, :show, :create]
    post '/recipe/confirmation' => 'recipes#confirmation'


  end

  #ゲストログイン用のルーティング
  devise_scope :customer do
    post '/guest_sign_in', to: 'public/sessions#new_guest'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  ##admin_action
  namespace :admin do
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
