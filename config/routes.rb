Rails.application.routes.draw do
  root "static_pages#home"

  post 'entries' => 'entries#create'
end
