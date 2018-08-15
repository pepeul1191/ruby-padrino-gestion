App::Archivos.controllers :video do
  before :listar do

  end

  get :count, :map => '/video/count' do
    rpta = nil
		status = 200
		begin
			rpta = Models::Archivos::Video.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar los videos',
					e.message
				]
			}
			status = 500
		end
    status status
    rpta.to_json
  end
end
