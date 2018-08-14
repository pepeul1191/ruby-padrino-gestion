App::Accesos.controllers :usuario do
  before :listar, :guardar do
    check_csrf
  end

  get :listar, :map => '/usuario/listar' do
    rpta = []
    status = 200
    begin
      rpta = Models::Accesos::Usuario.select(:id, :usuario, :correo).all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los usuarios',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  get :usuario_correo_estado, :map => '/usuario/obtener_usuario_correo/:usuario_id' do
    rpta = []
    status = 200
    begin
      usuario_id = params['usuario_id']
      rpta = Models::Accesos::VWUsuarioCorreoEstado.where(:id => usuario_id).first()
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en obtener los datos del usuario',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end
end
