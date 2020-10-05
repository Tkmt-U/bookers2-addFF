Rails.application.routes.draw do
  devise_for :users
  resources :books do 
    # book/:book_id/~~~/:id
    # book/:book_id/~~~
    resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show,:index,:edit,:update]
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
end