Padrino.configure_apps do
  helpers do
    def random_string_number
      length = 10
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      radom_value = ''
      length.times { radom_value << chars[rand(chars.size)] }
      radom_value
    end

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
      begin
        rpta = Models::Accesos::Modulo.all().to_a
      rescue Exception => e
        status = 500
        t = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en listar módulos',
            e.message
          ]}
        puts 'menu_modulos - error'
        puts t
      end
      rpta.to_json
    end

    def menu_items(modulo)
      rpta = []
      begin
        rs = Models::Accesos::VWModuloSubtituloItem.where(:modulo => modulo).all().to_a
        subtitulos = []
        subtitulos_temp = []
        items = []
        for r in rs
          subtitulo = r.subtitulo
          if subtitulos.include?(subtitulo) == false
            subtitulos.push(subtitulo)
            i = {
              :subtitulo => r.subtitulo,
              :items => [],
            }
            items.push(i)
          end
          t = {
            :subtitulo => r.subtitulo,
            :item => r.item,
            :url => r.url_item,
          }
          subtitulos_temp.push(t)
        end
        for subtitulo in subtitulos
          for temp in subtitulos_temp
            if(temp[:subtitulo] == subtitulo)
              i = {
                :item => temp[:item],
                :url => temp[:url],
              }
              for item in items
                if subtitulo == item[:subtitulo]
                  item[:items].push(i)
                end
              end
            end
          end
        end
        rpta = items
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
  end
end
