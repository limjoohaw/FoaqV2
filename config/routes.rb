Rails.application.routes.draw do
  devise_for :users
  notify_to :users, with_devise: :users
  
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :questions do
	  resources :answers, only: [:create, :show]
	  resources :votes, only: [:create]
	end

	resources :users, except: [:create]

	resources :categories

	get "/searchresult" => "questions#searchresult"

end
