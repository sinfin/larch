Larch::Engine.routes.draw do
  resources :menu_items do
    post 'move', on: :member
  end
end
