Rails.application.routes.draw do
  resources :tweets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
#  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "admin/users#index"
  # 
  namespace :admin do
    # 顧客
    resources :clients do
      member do
        # /admin/clients/:id/users/(:users_id)
        get 'users/(:user_id)', to: 'clients#users', as: 'users'
      end
    end
    resources :users                                     # ユーザー
    # ロール
    resources :roles do
      member do
        # /admin/roles/:id/users/(:users_id)
        get 'users/(:user_id)', to: 'roles#users', as: 'users'
        # /admin/roles/:id/menus/(:menus_id)
        get 'menus/(:menu_id)', to: 'roles#menus', as: 'menus'
      end
      # ロールとメニューのN:Nリレーション
      resources :role_menus, only: [] do
        collection do
          get   :edit
          patch :update
        end
      end
    end
    resources :menus                                     # メニュー
  end
  namespace :service do
    resources :articles
  end
end
