App::Archivos.controllers :extension do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/extension/listar' do
    some_method
    rpta = []
    status = 200
    begin
      rpta = Models::Archivos::Extension.all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar las extensiones',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  get :count, :map => '/extension/count' do
    rpta = nil
    status = 200
    begin
      rpta = Models::Archivos::Extension.all().count
    rescue Exception => e
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en contar las extensiones',
          e.message
        ]
      }
      status = 500
    end
    status status
    rpta.to_json
  end

  get :buscar_pagina, :map => '/extension/buscar_pagina' do
    rpta = nil
		status = 200
		begin
			data = JSON.parse(params['data'])
		  step = data['step']
		  page = data['page']
			inicio = (page - 1) * step
			rpta = Models::Archivos::Extension.order(:id).limit(step, inicio).to_a
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las extensiones',
					e.message
				]
			}.to_json
			status = 500
		end
    status status
    rpta.to_json
  end

  post :guardar, :map => '/extension/guardar' do
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
            n = Models::Archivos::Extension.new(
                  :nombre => nuevo['nombre'],
                  :mime => nuevo['mime'],
                )
            n.save
            t = {:temporal => nuevo['id'], :nuevo_id => n.id}
            array_nuevos.push(t)
          end
        end
        if editados.length != 0
          editados.each do |editado|
            e = Models::Archivos::Extension.where(:id => editado['id']).first
            e.nombre = editado['nombre']
            e.mime = editado['mime']
            e.save
          end
        end
        if eliminados.length != 0
          eliminados.each do |eliminado|
            Models::Archivos::Extension.where(:id => eliminado).delete
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
          'Se ha registrado los cambios en las extensiones',
          array_nuevos
          ]
        }
    else
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en guardar la tabla de extensiones',
          execption.message]
        }
    end
    status status
    rpta.to_json
  end
end
