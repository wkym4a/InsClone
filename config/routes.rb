Rails.application.routes.draw do

  #開発環境ではletter_openerでメール送信を確認する。
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'tops#index'

  resources :pictures do
    collection do
      post :confirm
    end
    member do
      post :edit_confirm
    end
  end

  resources :users do
    member do
      get :show_aftercreate
      get :edit_password
      patch :update_password
    end
  end

  resources :sessions ,only: [:new ,:create ,:destroy]
end
