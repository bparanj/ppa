Ppa::Application.routes.draw do
  
  match 'permissions/get_access_token' => 'permissions#get_access_token'
  
  root to: 'permissions#show'
  
  mount PermissionsSamples::Engine => "/samples" if Rails.env.development?
end
