App::Ubicaciones.controllers :provincia do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/provincia/listar/:departamento_id' do
    some_method
    rpta = []
    status = 200
    begin
      departamento_id = params['departamento_id']
      rpta = Models::Ubicaciones::Provincia.select(:id, :nombre).where(:departamento_id => departamento_id).all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar las provincias del departamento',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end
end
