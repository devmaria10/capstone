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
  get '/providers/:id' => 'providers#show'
  patch '/providers/:id' => 'providers#update'
  delete '/providers/:id' => 'providers#destroy'

  get '/diagnoses' => 'diagnoses#index'
  post 'diagnoses' => 'diagnoses#create'
  get '/diagnoses/:id' => 'diagnoses#show'
  patch '/diagnoses/:id' => 'diagnoses#update'
  delete '/diagnoses/:id' => 'diagnoses#destroy'

  get'/usermedications' => 'usermedications#index'
  post '/usermedications' => 'usermedications#create'
  get '/usermedications/:id' => 'usermedications#show'
  patch '/usermedications/:id' => 'usermedications#update'
  delete '/usermedications/:id' => 'usermedications#destroy'

  get '/userproviders' => 'userproviders#index'
  post '/userproviders' => 'userproviders#create'
  get 'userproviders/:id' => 'userproviders#show'
  patch 'userproviders/:id' => 'userproviders#update'
  delete '/userproviders/:id' => 'userproviders#destroy'

  get '/timers' => 'timers#index'
  post '/timers' => 'timers#create'
  get '/timers/:id' => 'timers#show'
  patch '/timers/:id' => 'timers#update'
  delete '/timers/:id' => 'timers#destroy'
end
