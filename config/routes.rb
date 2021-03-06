Rails.application.routes.draw do
  
  resources :events
  root 'static_pages#home'
  get  '/help',       to: 'static_pages#help'
  get  '/about',      to: 'static_pages#about'
  get  '/contact',    to: 'static_pages#contact'
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :show
end
