Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
    get '/' => 'homes#top'
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/customers/mypage' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    get '/customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch '/customers/information' => 'customers#update'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    get '/orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :index, :show, :create]
    post '/orders/confirm' => 'orders#confirm'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
