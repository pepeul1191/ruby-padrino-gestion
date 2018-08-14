App::Accesos.controllers :index do
  get :index, :map => '/' do
    locals = {
      :constants => CONSTANTS,
      :csss => index_css(),
      :jss => index_js(),
      :title => 'Bienvenido',
      :modulos => menu_modulos,
  		:items => '[]', #menu_items('Accesos'),
      :data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Accesos',
  			:modulo => 'Accesos',
  		}.to_json,
    }
    erb :'accesos/index', :layout => :'app.erb', :locals => locals
  end
end
