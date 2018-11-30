Rails.application.routes.draw do

  resources :validators

  post 'validators/validate'
  
  root "validators#index"
end
