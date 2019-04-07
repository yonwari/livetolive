Rails.application.routes.draw do
  root 'roots#top'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  get '/admin_top', to: 'roots#admin_top'
  resources :events, except: [:destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :calendar_events, only: [:create, :destroy]
  end
  resources :users, except: [:destroy]
  resources :places, except: [:destroy]
  resources :comedians, except: [:destroy]
  get 'inquiries/new'
  get 'inquiries/confirm'
  post 'inquiries/confirm' => 'inquiries#confirm'
  get 'inquiries/thanks'
  get  'new' =>'inquiries#new'
  post 'thanks' => 'inquiries#thanks'

  get '/events/comedian/:name', to: "events#comediantag"

  # 開発環境メール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
