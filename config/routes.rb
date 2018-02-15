Rails.application.routes.draw do
  get '/users' => 'users#index'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'
  patch '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'

  get '/medications' => 'medications#index'
  post '/medications' => 'medications#create'
  get '/medications/:id' => 'medications#show'
  patch '/medications/:id' => 'medications#update'
  delete '/medications/:id' => 'medications#destroy'

  get '/providers' => 'providers#index'
  post '/providers' => 'providers#create'
  get '/providers' => 'providers#show'
  patch '/providers/:id' => 'providers#update'
  delete '/providers/:id' => 'providers#destroy'

  get '/diagnoses' => ''
end
