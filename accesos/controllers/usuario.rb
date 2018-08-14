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

  post :correo_repetido, :map => '/usuario/correo_repetido' do
    rpta = 0
    error = false
    status = 200
    begin
      data = JSON.parse(params[:data])
      usuario_id = data['id']
      correo = data['correo']
      rpta = 0
      if usuario_id == 'E'
        #SELECT COUNT(*) AS cantidad FROM usuarios WHERE correo = ?
        rpta = Models::Accesos::Usuario.where(:correo => correo).count
      else
        #SELECT COUNT(*) AS cantidad FROM usuarios WHERE correo = ? AND id = ?
        rpta = Models::Accesos::Usuario.where(:correo => correo, :id => usuario_id).count
        if rpta == 1
          rpta = 0
        else
          #SELECT COUNT(*) AS cantidad FROM usuarios WHERE correo = ?
          rpta = Models::Accesos::Usuario.where(:correo => correo).count
        end
      end
      rpta = rpta.to_s
    rescue Exception => e
      error = true
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en validar el correo del usuario',
          e.message
        ]}.to_json
    end
    status status
    rpta
  end

  post :nombre_repetido, :map => '/usuario/nombre_repetido' do
    rpta = 0
    error = false
    status = 200
    begin
      data = JSON.parse(params[:data])
  	  usuario_id = data['id']
   	  usuario = data['usuario']
  		rpta = 0
  		if usuario_id == 'E'
  			#SELECT COUNT(*) AS cantidad FROM usuarios WHERE usuario = ?
  			rpta = Models::Accesos::Usuario.where(:usuario => usuario).count
  		else
  			#SELECT COUNT(*) AS cantidad FROM usuarios WHERE usuario = ? AND id = ?
  			rpta = Models::Accesos::Usuario.where(:usuario => usuario, :id => usuario_id).count
  			if rpta == 1
  				rpta = 0
  			else
  				#SELECT COUNT(*) AS cantidad FROM usuarios WHERE usuario = ?
  				rpta = Models::Accesos::Usuario.where(:usuario => usuario).count
  			end
  		end
      rpta = rpta.to_s
    rescue Exception => e
      error = true
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en validar el nombre de usuario repetido',
          e.message
        ]}.to_json
    end
    status status
    rpta
  end

  post :guardar_usuario_correo, :map => '/usuario/guardar_usuario_correo' do
    data = JSON.parse(params[:usuario])
    rpta = []
    status = 200
    DB_ACCESOS.transaction do
      begin
        id = data['id']
        usuario = data['usuario']
        correo = data['correo']
        estado_usuario_id = data['estado_usuario_id']
        DB_ACCESOS.transaction do
          begin
            e = Models::Accesos::Usuario.where(:id => id).first
            e.usuario = usuario
            e.correo = correo
            e.estado_usuario_id = estado_usuario_id
            e.save
          rescue Exception => e
            error = true
            Sequel::Rollback
          end
        end
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha registrado los cambios en los datos generales del usuario',
          ]}
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en guardar los datos generales del usuario',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end

  get :listar_usuario_rol, :map => '/usuario/rol/:usuario_id' do
    rpta = []
    status = 200
    DB_ACCESOS.transaction do
      begin
        usuario_id = params[:usuario_id]
        sistema_id = params[:sistema_id]
        rpta = DB_ACCESOS.fetch('
          SELECT T.id AS id, T.nombre AS nombre, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe FROM
          (
            SELECT id, nombre, 0 AS existe FROM roles
          ) T
          LEFT JOIN
          (
            SELECT R.id, R.nombre, 1 AS existe  FROM roles R
            INNER JOIN usuarios_roles UR ON R.id = UR.rol_id
            WHERE UR.usuario_id = ' + usuario_id + '
          ) P
          ON T.id = P.id').to_a
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en listar los roles del usuario',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end

  post :guardar_usuario_rol, :map => '/usuario/rol/guardar' do
    rpta = []
    status = 200
    data = JSON.parse(params[:data])
    editados = data['editados']
    usuario_id = data['extra']['usuario_id']
    DB_ACCESOS.transaction do
      begin
        if editados.length != 0
          editados.each do |editado|
            existe = editado['existe']
            rol_id = editado['id']
            e = Models::Accesos::UsuarioRol.where(
              :rol_id => rol_id,
              :usuario_id => usuario_id
            ).first
            if existe == 0 #borrar si existe
              if e != nil
                e.delete
              end
            elsif existe == 1 #crear si no existe
              if e == nil
                n = Models::Accesos::UsuarioRol.new(
                  :rol_id => rol_id,
                  :usuario_id => usuario_id
                )
                n.save
              end
            end
          end
        end
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha registrado la asociación de roles al usuario',
          ]}
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en asociar los roles del usuario',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end

  get :listar_usuario_permiso, :map => '/usuario/permiso/:usuario_id' do
    rpta = []
    status = 200
    DB_ACCESOS.transaction do
      begin
        usuario_id = params[:usuario_id]
        rpta = DB_ACCESOS.fetch('
          SELECT T.id AS id, T.nombre AS nombre, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe, T.llave AS llave FROM
          (
            SELECT id, nombre, llave, 0 AS existe FROM permisos
          ) T
          LEFT JOIN
          (
            SELECT P.id, P.nombre,  P.llave, 1 AS existe  FROM permisos P
            INNER JOIN usuarios_permisos UP ON P.id = UP.permiso_id
            WHERE UP.usuario_id = ' + usuario_id + '
          ) P
          ON T.id = P.id').to_a
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en listar los permisos del usuario',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end

  post :guardar_usuario_permiso, :map => '/usuario/permiso/guardar' do
    rpta = []
    status = 200
    data = JSON.parse(params[:data])
    editados = data['editados']
    usuario_id = data['extra']['usuario_id']
    DB_ACCESOS.transaction do
      begin
        if editados.length != 0
          editados.each do |editado|
            existe = editado['existe']
            permiso_id = editado['id']
            e = Models::Accesos::UsuarioPermiso.where(
              :permiso_id => permiso_id,
              :usuario_id => usuario_id
            ).first
            if existe == 0 #borrar si existe
              if e != nil
                e.delete
              end
            elsif existe == 1 #crear si no existe
              if e == nil
                n = Models::Accesos::UsuarioPermiso.new(
                  :permiso_id => permiso_id,
                  :usuario_id => usuario_id
                )
                n.save
              end
            end
          end
        end
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha registrado la asociación de permisos al usuario',
          ]}
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en asociar los permisos del usuario',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end
end
