Rails.application.routes.draw do

  # HomePage
  root to: 'home#index'

  # Articles page/Création de brouillon
  resources :blog, as: :articles, controller: 'articles', only: [:index, :show]
  scope '/draft' do
    get '/', to: 'posts#draft_index', as: :draft_index

    get '/new', to: 'posts#draft', as: :draft_new
    post '/new', to: 'posts#create_draft'

    get '/:id/edit', to: 'posts#edit_draft', as: :edit_draft
    patch '/:id/edit', to: 'posts#update_draft'

    get '/:id/publish', to: 'posts#publish', as: :publish_draft
  end
  # Supression des brouillon
  get '/drafts/:id', to: 'drafts#destroy', as: :dra

  #Inscription, connexion et déconnexion des utilisateurs
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout', as: :logout_session
  match '/forgot', to: 'sessions#forgot', as: :forgot, via: [:get, :post]
  match '/password/new', to: 'sessions#password', as: :forgot_success, via: [:get, :post]
  resources :users, only: [:new, :create]

  scope '/profil' do
    get '/', to: 'users#account', as: :profil

    get '/edit', to: 'users#edit', as: :edit_user
    patch '/edit', to: 'users#update'

    get '/:id', to: 'users#show', as: :view_user
  end

  scope '/dashboard', as: :admin do
    get '/', to: 'admin/pages#index', as: :index
    resources :articles, controller: 'admin/posts'
    resources :tutoriels, controller: 'admin/tutoriels'
  end

  scope '/blog' do
    get '/like/:post_id/:user_id', to: 'articles#like', as: :likes
    get '/unlike/:id/:post_id', to: 'articles#unlike', as: :unlikes
    post '/:slug', to: 'articles#create_comment', as: :new_comment
    get '/comment/like/:comment_id/:post_id', to: 'articles#like_comment', as: :like_comment
    get '/comment/unlike/:comment_id/:post_id', to: 'articles#unlike_comment', as: :unlike_comment
  end

  get '/tutoriels/:category_name', to: 'tutoriels#show', as: :category_view
  get '/tutoriels/:category/:title', to: 'tutoriels#show_tutoriel', as: :show_tuto
  resources :tutoriels, only: [:index]
end
