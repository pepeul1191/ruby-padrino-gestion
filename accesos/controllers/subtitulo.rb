App::Accesos.controllers :subtitulo do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/subtitulo/listar/:modulo_id' do
    rpta = []
    status = 200
    begin
      modulo_id = params['modulo_id']
      rpta = Models::Accesos::Subtitulo.select(:id, :nombre).where(:modulo_id => modulo_id).all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los subtítulos',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end

  post :guardar, :map => '/subtitulo/guardar' do
    rpta = nil
    status = 200
    data = JSON.parse(params[:data])
    nuevos = data['nuevos']
    editados = data['editados']
    eliminados = data['eliminados']
    modulo_id = data['extra']['modulo_id']
    rpta = []
    array_nuevos = []
    error = false
    execption = nil
    DB_ACCESOS.transaction do
      begin
        if nuevos.length != 0
          nuevos.each do |nuevo|
            n = Models::Accesos::Subtitulo.new(
              :nombre => nuevo['nombre'],
              :modulo_id => modulo_id,
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
            e = Models::Accesos::Subtitulo.where(:id => editado['id']).first
            e.nombre = editado['nombre']
            e.save
          end
        end
        if eliminados.length != 0
          eliminados.each do |eliminado|
            Models::Accesos::Subtitulo.where(:id => eliminado).delete
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
          'Se ha registrado los cambios en los subtítulos',
          array_nuevos
          ]
        }
    else
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en guardar la tabla de subtítulos',
          execption.message]
        }
    end
    status status
    rpta.to_json
  end
end
