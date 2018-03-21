Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/view_profile' => 'users#view_profile'
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
  get '/providers/:id' => 'providers#show'
  patch '/providers/:id' => 'providers#update'
  delete '/providers/:id' => 'providers#destroy'

  get '/diagnoses' => 'diagnoses#index'
  post 'diagnoses' => 'diagnoses#create'
  get '/diagnoses/:id' => 'diagnoses#show'
  patch '/diagnoses/:id' => 'diagnoses#update'
  delete '/diagnoses/:id' => 'diagnoses#destroy'

  get'/user_medications' => 'user_medications#index'
  post '/user_medications' => 'user_medications#create'
  get '/user_medications/:id' => 'user_medications#show'
  patch '/user_medications/:id' => 'user_medications#update'
  delete '/user_medications/:id' => 'user_medications#destroy'

  get '/user_providers' => 'user_providers#index'
  post '/user_providers' => 'user_providers#create'
  get 'user_providers/:id' => 'user_providers#show'
  patch 'user_providers/:id' => 'user_providers#update'
  delete '/user_providers/:id' => 'user_providers#destroy'

  get '/timers/call' => 'timers#call'

  get '/timers' => 'timers#index'
  post '/timers' => 'timers#create'
  get '/timers/:id' => 'timers#show'
  patch '/timers/:id' => 'timers#update'
  delete '/timers/:id' => 'timers#destroy'

end
