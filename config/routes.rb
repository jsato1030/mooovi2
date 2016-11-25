TechReviewSite::Application.routes.draw do
  devise_for :users
  root  'products#index'
  get 'products/search' => 'products#search'
  get 'products/:id'  => 'products#show'
  get 'products/:id/reviews/new'  => 'reviews#new'
end
