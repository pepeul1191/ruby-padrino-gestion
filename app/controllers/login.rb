App::App.controllers :login do
  get :index, :map => '/login' do
    some_method
    locals = {
      :constants => CONSTANTS,
      :csss => login_css(),
      :jss => login_js(),
      :title => 'Bienvenido',
      :mensaje => ''
    }
		erb :'login/index', :layout => :'blank.erb', :locals => locals
  end
end
