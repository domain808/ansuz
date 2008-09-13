ActionController::Routing::Routes.draw do |map|
  map.from_plugin :ansuz_photo_album
  map.from_plugin :ansuz_blog
  map.from_plugin :savage_beast
  map.from_plugin :ansuz_content_section

  map.resources :users
  map.namespace :admin do |admin|
    admin.resources :pages, :member => [:shift_order]
    admin.resources :page_plugins
    admin.resources :plugins
    admin.resource  :account
    admin.connect 'account/:action/:id', :controller => 'account'
    admin.resource  :site_settings
  end
  map.connect '/admin', :controller => 'admin/pages'

  # stock rails routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # Ansuz route
  map.connect '/pages/*path', :controller => 'page', :action => 'indexer'
  map.connect '', :controller => 'page', :action => 'indexer', :path => ''
end
