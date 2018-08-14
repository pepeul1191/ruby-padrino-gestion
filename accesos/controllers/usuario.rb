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

  post :contrasenia_repetida, :map => '/usuario/contrasenia_repetida' do
    rpta = 0
    error = false
    status = 200
    begin
      data = JSON.parse(params[:data])
      usuario_id = data['id']
      contrasenia = data['contrasenia']
      rpta = Models::Accesos::Usuario.where(:contrasenia => contrasenia, :id => usuario_id).count
      rpta = rpta.to_s
    rescue Exception => e
      error = true
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en validar la contraseña del usuario',
          e.message
        ]}.to_json
    end
    status status
    rpta
  end

  post :guardar_contrasenia, :map => '/usuario/guardar_contrasenia' do
    data = JSON.parse(params[:contrasenia])
    rpta = []
    status = 200
    DB_ACCESOS.transaction do
      begin
        id = data['id']
        contrasenia = data['contrasenia']
        DB_ACCESOS.transaction do
          begin
            e = Usuario.where(:id => id).first
            e.contrasenia = contrasenia
            e.save
          rescue Exception => e
            error = true
            Sequel::Rollback
          end
        end
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha el cambio de contraseña del usuario',
          ]}
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en actualizar la contraseña del usaurio',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end
end
