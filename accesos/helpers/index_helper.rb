# Helper methods defined here can be accessed in any controller or view in the application

module App
  class Accesos
    module IndexHelper
      def index_css
        rpta = nil
        if CONSTANTS[:ambiente] == 'desarrollo'
          rpta = [
            'bower_components/bootstrap/dist/css/bootstrap.min',
            'bower_components/font-awesome/css/font-awesome.min',
            'bower_components/swp-backbone/assets/css/constants',
            'bower_components/swp-backbone/assets/css/dashboard',
            'bower_components/swp-backbone/assets/css/table',
            'bower_components/swp-backbone/assets/css/autocomplete',
            'assets/css/constants',
            'assets/css/styles',
          ]
        else
          rpta = [
            'dist/login.min',
          ]
        end
        rpta
      end

      def index_js
        rpta = nil
        if CONSTANTS[:ambiente] == 'desarrollo'
          rpta = [
            'bower_components/jquery/dist/jquery.min',
            'bower_components/bootstrap/dist/js/bootstrap.min',
            'bower_components/underscore/underscore-min',
            'bower_components/backbone/backbone-min',
            'bower_components/handlebars/handlebars.min',
            'bower_components/swp-backbone/layouts/application',
            'bower_components/swp-backbone/views/table',
            'bower_components/swp-backbone/views/modal',
            'bower_components/swp-backbone/views/upload',
            'bower_components/swp-backbone/views/autocomplete',
            'models/accesos/sistema',
            'models/accesos/modulo',
            'models/accesos/subtitulo',
            'models/accesos/item',
            'models/accesos/permiso',
            'models/accesos/rol',
            'models/accesos/usuario',
            'models/accesos/estado_usuario',
            'collections/accesos/estado_usuario_collection',
            'collections/accesos/sistema_collection',
            'collections/accesos/modulo_collection',
            'collections/accesos/subtitulo_collection',
            'collections/accesos/item_collection',
            'collections/accesos/permiso_collection',
            'collections/accesos/rol_collection',
            'collections/accesos/usuario_collection',
            'data/accesos/tabla_sistema_data',
            'data/accesos/tabla_sistema_permiso_data',
            #'data/accesos/modal_sistema_menu_data',
            #'data/accesos/modal_sistema_permiso_data',
            #'data/accesos/modal_sistema_rol_data',
            #'data/accesos/modal_usuario_detalle_data',
            #'data/accesos/modal_usuario_sistema_data',
            #'data/accesos/modal_usuario_log_data',
            #'data/accesos/modal_usuario_rol_permiso_data',
            #'data/accesos/tabla_sistema_modulo_data',
            'data/accesos/tabla_modulo_subtitulo_data',
            'data/accesos/tabla_subtitulo_item_data',
            #'data/accesos/tabla_sistema_rol_data',
            #'data/accesos/tabla_rol_permiso_data',
            #'data/accesos/tabla_usuario_data',
            #'data/accesos/tabla_usuario_sistema_data',
            #'data/accesos/tabla_usuario_rol_data',
            #'data/accesos/tabla_usuario_permiso_data',
            'data/accesos/tabla_modulo_data',
            'views/accesos/modulo_view',
            #'views/accesos/sistema_view',
            #'views/accesos/sistema_menu_view',
            #'views/accesos/sistema_permiso_view',
            #'views/accesos/sistema_rol_view',
            #'views/accesos/usuario_view',
            'views/accesos/usuario_log_view',
            'views/accesos/usuario_detalle_view',
            'views/accesos/usuario_sistema_view',
            'views/accesos/usuario_rol_permiso_view',
            'routes/accesos',
          ]
        else
          rpta = [
          ]
        end
        rpta
      end
    end

    helpers IndexHelper
  end
end
