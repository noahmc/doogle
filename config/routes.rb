Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "static_pages#home"

  post 'entries' => 'entries#create'
end
