TechReviewSite::Application.routes.draw do
  root  'products#index'
  get 'products/search' => 'products#search'
  get 'products/:id'  => 'products#show'
end
