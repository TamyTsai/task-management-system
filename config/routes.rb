Rails.application.routes.draw do
  devise_for :users

  resources :lists do
    # url: `/lists/${this.lists[event.moved.newIndex].id}/move`
    member do
      put :move
      # move_list    PUT    /lists/:id/move(.:format)         lists#move
    end
  end

  resources :cards
  
  root 'lists#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
