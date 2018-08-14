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
end
