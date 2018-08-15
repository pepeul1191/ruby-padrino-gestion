App::Archivos.controllers :video do
  before :listar do

  end

  get :count, :map => '/video/count' do
    rpta = nil
		status = 200
		begin
			rpta = Models::Archivos::Video.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar los videos',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  get :buscar_pagina, :map => '/video/buscar_pagina' do
    rpta = nil
    status = 200
    begin
      data = JSON.parse(params['data'])
      step = data['step']
      page = data['page']
      inicio = (page - 1) * step
      #rpta = Archivos::Video.select(:id, :nombre, :duracion).order(:id).limit(step, inicio).to_a.to_json
      videos = Models::Archivos::Video.select(:id, :nombre, :duracion, :anio).order(:id).limit(step, inicio).to_a
      rpta = []
      videos.each do |video|
        temp = Hash.new
        temp[:id] = video.id
        temp[:nombre] = video.nombre
        temp[:duracion] = video.duracion
        temp[:anio] = video.anio
        temp[:autores] = ''
        temp[:categorias] = ''
        k = 0
        autores = Models::Archivos::VWVideoAutor.select(:autor_nombre).where(:video_id => video.id).to_a
        puts autores
        autores.each do |autor|

          if k == 0
            temp[:autores] = autor.autor_nombre
          else
            temp[:autores] = temp[:autores] + ', ' + autor.autor_nombre
          end
          k = k + 1
        end
        k = 0
        categorias = Models::Archivos::VWVideoCategoria.select(:categoria_nombre).where(:video_id => video.id).to_a
        categorias.each do |categoria|
          if k == 0
            temp[:categorias] = categoria.categoria_nombre
          else
            temp[:categorias] = temp[:categorias] + ', ' + categoria.categoria_nombre
          end
          k = k +1
        end
        rpta.push(temp)
      end
    rescue Exception => e
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los videos',
          e.message
        ]
      }
      status = 500
    end
    status status
    rpta.to_json
  end

  get :count, :map => '/video/listar/autores/:video_id' do
    rpta = nil
		status = 200
		begin
			rpta = Models::Archivos::VWVideoAutor.select(:id, :autor_id, :autor_nombre).where(:video_id => params[:video_id]).all().to_a
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los autores del video',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  get :count, :map => '/video/listar/categorias/:video_id' do
    rpta = nil
		status = 200
		begin
			rpta = Models::Archivos::VWVideoCategoria.select(:id, :video_id, :categoria_id, :categoria_nombre).where(:video_id => params[:video_id]).all().to_a
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las categorias del video',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  post :guardar_detalle, :map => '/video/guardar_detalle' do
    rpta = nil
    status = 200
    data = JSON.parse(params[:data])
    begin
      if data['id'] == 'E'
        video = Models::Archivos::Video.new(:nombre => data['nombre'], :duracion => data['duracion'], :anio => data['anio'])
        video.save
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha registrado el detalle de un nuevo video',
            video.id,
          ]
        }
      else
        archivo = Models::Archivos::Video.where(:id => data['id']).first
        archivo.nombre = data['nombre']
        archivo.duracion = data['duracion']
        archivo.anio = data['anio']
        archivo.save
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha editado el detalle de video',
          ]
        }
      end
    rescue Exception => e
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en registrar el detalle del video',
          e
        ]
      }
      status = 500
    end
    status status
    rpta.to_json
  end
end
