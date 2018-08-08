##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'cf31aa1c1bf466e31c98a1de144541a9d9fcd2c729e50723ff4ced9e5f34cc92'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, true
  set :views, Proc.new { File.join('views') }
  set :erb, :layout => Proc.new { File.join('views/layouts') }

  before do
    headers['Server'] = 'Ruby, Ubuntu'
  end

  error Sinatra::NotFound do
    rpta = ''
    case request.env['REQUEST_METHOD']
    when 'GET'
      redirect '/error/access/404'
    else
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Recurso no encontrado',
          'El recurso que busca no se encuentra en el servidor'
        ]}
    end
    status 404
    rpta.to_json
  end
end

# Mounts the core application for this project

Padrino.mount('App::Ubicaciones', :app_file => Padrino.root('ubicaciones/app.rb')).to('/ubicaciones')
Padrino.mount('App::App', :app_file => Padrino.root('app/app.rb')).to('/')
