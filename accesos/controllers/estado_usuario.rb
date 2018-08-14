App::Accesos.controllers :estado_usuario do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/estado_usuario/listar' do
    rpta = []
    status = 200
    begin
      modulo_id = params['modulo_id']
      rpta = Models::Accesos::EstadoUsuario.all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los estados de usuario',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end
end
