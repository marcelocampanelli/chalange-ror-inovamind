Rails.application.routes.draw do
  get '/crawler', to: 'crawler#index'
  get '/quotes', to: 'quotes#search'
end
