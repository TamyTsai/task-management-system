Rails.application.routes.draw do
  devise_for :users

  resources :lists, only: [:index, :create, :update, :destroy] do
    # url: `/lists/${this.lists[event.moved.newIndex].id}/move`
    member do
      put :move
      # move_list    PUT    /lists/:id/move(.:format)         lists#move
    end
  end

  resources :cards, only: [:create, :update, :destroy] do
    # url: `/cards/${card_id}/move`, // 移動第幾張卡片
    member do 
      put :move
      # move_card   PUT    /cards/:id/move(.:format)            cards#move
    end
  end
  
  root 'lists#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
