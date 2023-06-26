Rails.application.routes.draw do

  namespace :public do
    get 'comments/create'
  end
  root to: 'public/homes#top'

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲストログイン用のルーティング
  devise_scope :customer do
    post '/guest_sign_in', to: 'public/sessions#new_guest'
  end

  # 顧客用
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  ##admin_action
  namespace :admin do
  end

  ##public_action
  scope module: :public do
    get '/' => 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    resources :foods, only: [:index, :genre_search, :new, :create, :show, :edit, :update] do
      resources :comments, only: [:create]
    end

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
