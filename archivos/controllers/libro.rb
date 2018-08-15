App::Archivos.controllers :libro do
  before :listar do
    check_csrf
  end

  get :count, :map => '/libro/count' do
    rpta = nil
		status = 200
		begin
			rpta = Models::Archivos::Libro.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar los libros',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  get :buscar_pagina, :map => '/libro/buscar_pagina' do
    rpta = nil
		status = 200
		begin
			data = JSON.parse(params['data'])
			step = data['step']
			page = data['page']
			inicio = (page - 1) * step
			#rpta = Archivos::Libro.select(:id, :nombre, :paginas).order(:id).limit(step, inicio).to_a.to_json
			libros = Models::Archivos::Libro.select(:id, :nombre, :paginas, :anio).order(:id).limit(step, inicio).to_a
			rpta = []
			libros.each do |libro|
				temp = Hash.new
				temp[:id] = libro.id
				temp[:nombre] = libro.nombre
				temp[:paginas] = libro.paginas
				temp[:anio] = libro.anio
				temp[:autores] = ''
				temp[:categorias] = ''
				k = 0
				autores = Models::Archivos::VWLibroAutor.select(:autor_nombre).where(:libro_id => libro.id).to_a
				autores.each do |autor|
					if k == 0
						temp[:autores] = autor.autor_nombre
					else
						temp[:autores] = temp[:autores] + ', ' + autor.autor_nombre
					end
					k = k + 1
				end
				k = 0
				categorias = Models::Archivos::VWLibroCategoria.select(:categoria_nombre).where(:libro_id => libro.id).to_a
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
					'Se ha producido un error en listar los libros',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  get :count, :map => '/libro/listar/autores/:libro_id' do
    rpta = nil
		status = 200
		begin
      libro_id = params[:libro_id]
			rpta = Models::Archivos::VWLibroAutor.select(:id, :autor_id, :autor_nombre).where(:libro_id => libro_id).all().to_a
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los autores del libro',
					e.message
				]
			}
			status = 500
		end
    status status
		rpta.to_json
  end

  get :count, :map => '/libro/listar/categorias/:libro_id' do
    rpta = nil
		status = 200
		begin
      libro_id = params[:libro_id]
			rpta = Models::Archivos::VWLibroCategoria.select(:id, :libro_id, :categoria_id, :categoria_nombre).where(:libro_id => libro_id).all().to_a
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las categorias del libro',
					e.message
				]
			}
			status = 500
		end
    status status
		rpta.to_json
  end

  post :guardar, :map => '/libro/guardar_detalle' do
    rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		begin
			if data['id'] == 'E'
				libro = Models::Archivos::Libro.new(
          :nombre => data['nombre'],
          :paginas => data['paginas'],
          :anio => data['anio']
        )
				libro.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha registrado el detalle de un nuevo libro',
						libro.id,
					]
				}
			else
				archivo = Models::Archivos::Libro.where(:id => data['id']).first
				archivo.nombre = data['nombre']
				archivo.paginas = data['paginas']
				archivo.anio = data['anio']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha editado el detalle de libro',
					]
				}
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en registrar el detalle del libro',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  post :guardar_autor, :map => '/libro/guardar/autor' do
    rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		nuevos = data['nuevos']
		editados = data['editados']
		eliminados = data['eliminados']
		libro_id = data['extra']['libro_id']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Models::Archivos::LibroAutor.new(:libro_id => libro_id, :autor_id => nuevo['autor_id'])
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Models::Archivos::LibroAutor.where(:id => editado['id']).first
						e.autor_id = editado['autor_id']
						e.libro_id = libro_id
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Models::Archivos::LibroAutor.where(:id => eliminado).delete
					end
				end
			rescue Exception => e
				Sequel::Rollback
				error = true
				execption = e
			end
		end
		if error == false
			rpta = {
				:tipo_mensaje => 'success',
				:mensaje => [
					'Se ha registrado los cambios en las asociaciones de los autores al libro',
					array_nuevos
					]
				}
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en asociar los autores al libro',
					execption.message]
				}
		end
    status status
    rpta.to_json
  end
end
