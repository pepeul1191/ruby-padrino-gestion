App::Accesos.controllers :rol do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/rol/listar' do
    rpta = []
    status = 200
    begin
      modulo_id = params['modulo_id']
      rpta = Models::Accesos::Rol.select(:id, :nombre).all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los roles',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  post :guardar, :map => '/rol/guardar' do
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
            n = Models::Accesos::Rol.new(
              :nombre => nuevo['nombre'],
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
            e = Models::Accesos::Rol.where(:id => editado['id']).first
            e.nombre = editado['nombre']
            e.save
          end
        end
        if eliminados.length != 0
          eliminados.each do |eliminado|
            Models::Accesos::Rol.where(:id => eliminado).delete
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
          'Se ha registrado los cambios en los roles',
          array_nuevos
          ]
        }
    else
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en guardar la tabla de roles',
          execption.message]
        }
    end
    status status
    rpta.to_json
  end

  get :listar_permisos, :map => '/rol/permiso/listar/:rol_id' do
    rpta = []
    status = 200
    begin
      rol_id = params['rol_id']
      rpta = DB_ACCESOS.fetch('
    		SELECT T.id AS id, T.nombre AS nombre, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe, T.llave AS llave FROM
    		(
    			SELECT id, nombre, llave, 0 AS existe FROM permisos
    		) T
    		LEFT JOIN
    		(
    			SELECT P.id, P.nombre,  P.llave, 1 AS existe  FROM permisos P
    			INNER JOIN roles_permisos RP ON P.id = RP.permiso_id
    			WHERE RP.rol_id =  ' + rol_id + '
    		) P
    		ON T.id = P.id').to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los permosos del rol',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  post :guardar_permisos, :map => '/rol/permiso/guardar' do
    data = JSON.parse(params[:data])
    editados = data['editados']
    rol_id = data['extra']['rol_id']
    rpta = []
    status = 200
    DB_ACCESOS.transaction do
      begin
        if editados.length != 0
          editados.each do |editado|
            existe = editado['existe']
            permiso_id = editado['id']
            e = Models::Accesos::RolPermiso.where(
              :permiso_id => permiso_id,
              :rol_id => rol_id
            ).first
            if existe == 0 #borrar si existe
              if e != nil
                e.delete
              end
            elsif existe == 1 #crear si no existe
              if e == nil
                n = Models::Accesos::RolPermiso.new(
                  :permiso_id => permiso_id,
                  :rol_id => rol_id
                )
                n.save
              end
            end
          end
        end
        rpta = {
          :tipo_mensaje => 'success',
          :mensaje => [
            'Se ha registrado la asociación de permisos al rol',
          ]}
      rescue Exception => e
        Sequel::Rollback
        status = 500
        rpta = {
          :tipo_mensaje => 'error',
          :mensaje => [
            'Se ha producido un error en asociar los permisos al rol',
            e.message
          ]}
      end
    end
    status status
    rpta.to_json
  end
end
