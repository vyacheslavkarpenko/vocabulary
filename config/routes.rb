Rails.application.routes.draw do
  resources :translates
  get 'not_learned', to: 'translates#not_learned', as: 'not_learned'
  get 'for_repeat', to: 'translates#for_repeat', as: 'for_repeat'
  put 'update_learned', to: 'translates#update_learned', as: 'update_learned'
  put 'update_repeited', to: 'translates#update_repeited', as: 'update_repeited'
  root 'translates#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
