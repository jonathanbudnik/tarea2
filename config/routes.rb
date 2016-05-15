Rails.application.routes.draw do
  get 'api/index'
  get 'welcome/index'
  root 'welcome#index'
  match 'instagram/tag/buscar'=> 'api#index', via: :get
  match 'instagram/tag/buscar'=> 'api#usarApi', via: :post

end
