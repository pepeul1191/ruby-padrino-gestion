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
  end
end
