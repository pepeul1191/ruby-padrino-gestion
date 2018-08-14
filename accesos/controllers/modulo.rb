App::Accesos.controllers :modulo do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/modulo/listar' do
    rpta = []
    status = 200
    begin
      rpta = Models::Accesos::Modulo.all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los módulos',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  post :guardar, :map => '/modulo/guardar' do
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
		DB_ACCESOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Models::Accesos::Modulo.new(
              :nombre => nuevo['nombre'],
              :icono => nuevo['icono'],
              :url => nuevo['url'],
            )
						n.save
						t = {
              :temporal => nuevo['id'],
              :nuevo_id => n.id
            }
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Models::Accesos::Modulo.where(:id => editado['id']).first
						e.nombre = editado['nombre']
            e.icono = editado['icono']
            e.url = editado['url']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Models::Accesos::Modulo.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en los módulos',
					array_nuevos
					]
				}
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de módulos',
					execption.message]
				}
		end
    status status
    rpta.to_json
  end
end
