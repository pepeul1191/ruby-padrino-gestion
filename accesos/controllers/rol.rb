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
end
