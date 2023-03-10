Rails.application.routes.draw do
  get 'stimulus/tom-select'
  devise_for :users
  root to: "pages#home"
  get '/components', to: "pages#components"

  resources :schools, only: %i[index show new create] do
    collection do
      get :search
    end
    member do
      patch :assign_school
    end
    resources :week_menus, only: %i[index new edit update create] do
      collection do
        get :review
      end
      member do
        patch :update_status
      end
    end
    resources :profiles, only: %i[index show new create edit update] do
      resources :week_menus, only: %i[index show edit update]
      resources :intolerance_profiles, only: %i[index show new create]
      resources :allergy_profiles, only: %i[index show new create]
    end
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

  resources :intolerance_profiles do
    resources :intolerances
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
