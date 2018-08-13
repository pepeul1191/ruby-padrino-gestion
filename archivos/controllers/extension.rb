App::Archivos.controllers :extension do
  before :listar do
    check_csrf
  end

  get :listar, :map => '/extension/listar' do
    some_method
    rpta = []
    status = 200
    begin
      rpta = Models::Archivos::Extension.all().to_a
    rescue Exception => e
      status = 500
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar las extensiones',
          e.message
        ]}
    end
    status status
    rpta.to_json
  end
end
