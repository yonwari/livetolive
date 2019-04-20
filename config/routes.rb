Rails.application.routes.draw do
  root 'roots#top'
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  get '/admin_top', to: 'roots#admin_top'
  resources :events do
    resource :favorites, only: [:create, :destroy]
    resource :calendar_events, only: [:create, :destroy]
  end
  resources :users, except: [:destroy]
  resources :places, except: [:destroy]
  get 'place/search' => 'places#search'
  resources :comedians, except: [:destroy]
  get 'inquiries/new'
  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'thanks' => 'inquiries#thanks'

  # 開発環境メール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
