TavernaPlayerPortal::Application.routes.draw do

  # Mount Taverna Player at the root of this application.
  mount TavernaPlayer::Engine, at: "/"

  devise_for :users

  get "home/index"
  root 'home#index'

  resources :workflows do
    member do
      get 'download'
      get 'diagram'
    end

    # Nest the Taverna Player runs in the workflow resource.
    resources :runs, controller: 'taverna_player/runs'
  end

  get "admin/settings"
  put "admin/update_settings"

  # This application adds the ability to edit runs so specify that here.
  resources :runs, controller: 'taverna_player/runs', only: ['edit', 'update']

  resources :users, controller: 'application', :defaults => { :format => :json } do
    get 'runs'
  end

end
