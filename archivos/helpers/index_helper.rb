# Helper methods defined here can be accessed in any controller or view in the application

module App
  class Archivos
    module IndexHelper
      def archivos_index_css
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

      def archivos_index_js
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
            'models/archivos/extension',
            'models/archivos/autor',
            'models/archivos/categoria',
            'models/archivos/libro',
            'models/archivos/video',
            'models/archivos/archivo',
            'collections/archivos/extension_collection',
            'collections/archivos/autor_collection',
            'collections/archivos/categoria_collection',
            'collections/archivos/libro_collection',
            'collections/archivos/video_collection',
            'data/archivos/tabla_extension',
            'data/archivos/tabla_autor',
            'data/archivos/tabla_categoria',
            'data/archivos/tabla_libro',
            'data/archivos/tabla_libro_autor',
            'data/archivos/tabla_libro_categoria',
            'data/archivos/tabla_video',
            'data/archivos/tabla_video_autor',
            'data/archivos/tabla_video_categoria',
            'data/archivos/video_detalle',
            'data/archivos/libro_detalle',
            'data/archivos/libro_upload',
            'data/archivos/video_upload',
            'views/archivos/autor_view',
            'views/archivos/extension_view',
            'views/archivos/categoria_view',
            'views/archivos/libro_view',
            'views/archivos/libro_detalle_view',
            'views/archivos/video_detalle_view',
            'views/archivos/video_view',
            'routes/archivos',
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
