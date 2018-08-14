App::Archivos.controllers :index do
  get :index, :map => '/' do
    locals = {
      :constants => CONSTANTS,
      :csss => archivos_index_css(),
      :jss => archivos_index_js(),
      :title => 'Bienvenido',
      :modulos => menu_modulos,
      :items => menu_items('Archivos'),
      :data => {
        :mensaje => false,
        :titulo_pagina => 'Gestión de Archivos',
        :modulo => 'Archivos',
      }.to_json,
    }
    erb :'archivos/index', :layout => :'app.erb', :locals => locals
  end
end
