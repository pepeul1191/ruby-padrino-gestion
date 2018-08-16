CONSTANTS = {
  :base_url => 'http://localhost:3000/',
  :static_url => 'http://localhost:9090/',
  :csrf => {
    :secret => 'mpt/sr6eS2AlCRHU7DVThMgFTN08pnfSDf/C94eZx7udfm0lvgaYWLYJttYPKzGKDTlXwVU/d2FOxbKkgNlsTw==',
    :key => 'Csrf_Val',
  },
  :sistema_id => 4,
  :ambiente => 'desarrollo',
  :ambiente_static => 'desarrollo',
  :ambiente_csrf  => 'inactivo',
  :ambiente_session => 'activo',
  :key => 'Fdp6CVxpri1ga8kH',
  :static => {
    :accesos => 'http://localhost:9090/',
    :archivos => '',
  },
  :servicios => {
    :accesos => {
      :url => 'http://localhost:4000/',
      :csrf_key => 'csrf_val',
      :csrf_value => 'PKBcauXg6sTXz7Ddlty0nejVgoUodXL89KNxcrfwkEme0Huqtj6jjt4fP7v2uF4L',
    },
    :agricultor => 'http://localhost:3012/',
    :ubicaciones => 'http://localhost:3011/',
    :archivos => 'http://192.168.1.43:3031/',
    :estaciones => 'http://localhost:3025/',
    :sensores => 'http://localhost:3035/',
  },
  :ftp => {
    :dominio => '192.168.1.5',
    :puerto => 21,
    :usuario => 'ubuntu',
    :contrasenia => 'kiki123',
    :ruta => 'Documentos/nodejs/ftp/public/',
    :public => 'http://192.168.1.5:9090/'
  },
}
