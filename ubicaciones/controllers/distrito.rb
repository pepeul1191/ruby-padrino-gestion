App::Ubicaciones.controllers :distrito do
  before :listar, :nombre, :buscar do
    check_csrf
  end

  get :listar, :map => '/distrito/listar/:provincia_id' do
    some_method
    rpta = []
    status = 200
    begin
      provincia_id = params['provincia_id']
      rpta = Distrito.select(:id, :nombre).where(:provincia_id => provincia_id).all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los departamentos de la provincia',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  get :nombre, :map => '/distrito/nombre/:distrito_id' do
    some_method
    rpta = []
    status = 200
    begin
      distrito_id = params['distrito_id']
      rpta = VWDistritoProvinciaDepartamento.where(:id => distrito_id).first.nombre
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en buscar el distrito',
          e.message
        ]}.to_json
    end
    status status
    rpta
  end

  get :buscar, :map => '/distrito/buscar' do
    some_method
    rpta = []
    status = 200
    begin
      nombre = params['nombre']
      rpta = VWDistritoProvinciaDepartamento.where(Sequel.like(:nombre, nombre + '%')).limit(10).to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en buscar el distrito',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end
end
