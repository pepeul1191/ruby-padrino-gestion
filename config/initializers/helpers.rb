Padrino.configure_apps do
  helpers do
    def load_css(csss)
      rpta = ''
      if defined? csss
        csss.each do |css|
          temp = '<link href="' + CONSTANTS[:static_url] + css + '.css" rel="stylesheet"/>'
          rpta = rpta + temp
        end
      end
      rpta
    end

    def load_js(jss)
      rpta = ''
      if defined? jss
        jss.each do |js|
          temp = '<script src="' + CONSTANTS[:static_url] + js + '.js" type="text/javascript"></script>'
          rpta = rpta + temp
        end
      end
      rpta
    end

    def some_method
      puts '1 +++++++++++++++++++++++++++++'
    end

    def menu_modulos
      rpta = []
      status = 200
      begin
        rpta = Models::Accesos::Modulo.all().to_a
      rescue Exception => e
        status = 500
        t = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en listar los departamentos',
            e.message
          ]}
        puts 'menu_modulos - error'
        puts t
      end
      rpta.to_json
    end

    def menu_items(modulo)

    end
  end
end
