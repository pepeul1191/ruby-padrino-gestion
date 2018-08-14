App::Archivos.controllers :categoria do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/categoria/listar' do
    rpta = nil
		status = 200
		begin
			rpta = Models::Archivos::Categoria.all().to_a
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las categorias',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end

  post :guardar, :map => '/categoria/guardar' do
    rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		nuevos = data['nuevos']
		editados = data['editados']
		eliminados = data['eliminados']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Models::Archivos::Categoria.new(:nombre => nuevo['nombre'],)
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Models::Archivos::Categoria.where(:id => editado['id']).first
						e.nombre = editado['nombre']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Models::Archivos::Categoria.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en las categorias',
					array_nuevos
					]
				}
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de categorias',
					execption.message]
				}
		end
    status status
    rpta.to_json
  end
end
