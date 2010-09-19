Diminutiveurl::Application.routes.draw do
  #match '/' => 'links#new'
  match '/link' => 'links#new', :via => [:get]
  match '/link' => 'links#create', :via => [:post]
  match '/link/:id' => 'links#link', :via => [:get]
  match '/:id' => 'links#show', :via => [:get]
  match '/stats/:id' => 'stats#show', :via => [:get]

  root :to => 'links#new'
end