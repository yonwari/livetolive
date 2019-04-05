Rails.application.routes.draw do
  get 'roots/top'
  get 'roots/admin_top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'roots#top'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  get '/admin_top', to: 'roots#admin_top'
  resources :events, except: [:destroy]
  resources :users, except: [:destroy] do
    resources :favorites, only: [:create, :destroy]
    resources :calendar_events, only: [:create, :destroy]
  end
  resources :places, except: [:destroy]
  resources :comedians, except: [:destroy]
  get 'inquiries/new'
  get 'inquiries/confirm'
  post 'inquiries/confirm' => 'inquiries#confirm'
  get 'inquiries/thanks'

  get  'new' =>'inquiries#new'
  post 'thanks' => 'inquiries#thanks'

  # 開発環境メール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
