Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/components', to: "pages#components"

  resources :schools, only: %i[index show] do
    resources :profiles
  end

  resources :profiles, only: %i[index show] do
    resources :week_menus, only: %i[]
    resources :allergy_profiles
  end

  resources :week_menus do
    resources :day_menu
  end

  resources :day_menu do
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
