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
end
