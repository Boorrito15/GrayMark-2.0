Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/components', to: "pages#components"

  resources :schools, only: %i[index show new create] do
    resources :profiles, only: %i[index show new create]
  end

  resources :profiles, only: %i[edit index update show] do
    resources :week_menus, only: %i[index show new create]
    resources :allergy_profiles, only: %i[index show new create]
  end

  resources :week_menus, only: %i[show] do
    resources :day_menus, only: %i[index show new create]
  end

  resources :day_menu, only: %i[show] do
    resources :menu_dishes
  end

  resources :menu_dishes do
    resources :dishes
  end

  resources :allergy_profiles do
    resources :ingredients
  end

  resources :ingredients do
    resources :dish_ingredients
  end

  resources :dish_ingredients do
    resources :dishes
  end

  resources :dishes
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
