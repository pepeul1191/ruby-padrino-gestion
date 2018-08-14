App::Ubicaciones.controllers :departmaneto do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/departamento/listar' do
    rpta = []
    status = 200
    begin
      rpta = Models::Ubicaciones::Departamento.all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los departamentos',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end
end
